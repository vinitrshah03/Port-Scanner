package com.project.security;

import java.io.IOException;
import java.net.InetAddress;
import java.net.InetSocketAddress;
import java.net.Socket;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;
import java.util.concurrent.TimeUnit;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/networkscan")
public class PortScanner extends HttpServlet {

    private static final long serialVersionUID = 1L;
    
    public PortScanner() {
        super();
    }
    
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // Input parameters from the form
        String targetNetwork = req.getParameter("network");
        int startPort = Integer.parseInt(req.getParameter("startPort"));
        int endPort = Integer.parseInt(req.getParameter("endPort"));

        // Start time for the entire scan
        long startTime = System.currentTimeMillis();

        // Lists to store active and inactive hosts
        List<String> activeHosts = Collections.synchronizedList(new ArrayList<>());
        List<String> inactiveHosts = Collections.synchronizedList(new ArrayList<>());

        // Get all IP addresses in the specified network
        List<String> ipList = getIPAddresses(targetNetwork);

        // Using a cached thread pool for multithreading
        ExecutorService executorService = Executors.newCachedThreadPool();

        // Scan each host in the specified network
        for (String ip : ipList) {
            executorService.submit(() -> {
                try {
                    if (isHostReachable(ip, 1000)) {
                        activeHosts.add(ip);
                    } else {
                        inactiveHosts.add(ip);
                    }
                } catch (Exception e) {
                    inactiveHosts.add(ip);
                }
            });
        }

        // Shutdown the executor service and wait for tasks to complete
        executorService.shutdown();
        try {
            executorService.awaitTermination(Long.MAX_VALUE, TimeUnit.MILLISECONDS);
        } catch (InterruptedException e) {
            e.printStackTrace();
        }

        // Port scanning on active hosts
        List<Host> hostList = new ArrayList<>();
        
        for (String activeHost : activeHosts) {
            List<Integer> openPorts = Collections.synchronizedList(new ArrayList<>());
            List<Integer> closedPorts = Collections.synchronizedList(new ArrayList<>());
            
            ExecutorService portExecutor = Executors.newCachedThreadPool();
            for (int port = startPort; port <= endPort; port++) {
                final int currentPort = port;
                portExecutor.submit(() -> scanPort(activeHost, currentPort, openPorts, closedPorts));
            }
            portExecutor.shutdown();
            try {
                portExecutor.awaitTermination(Long.MAX_VALUE, TimeUnit.MILLISECONDS);
            } catch (InterruptedException e) {
                e.printStackTrace();
            }

            // Add the host and its port information to the list
            hostList.add(new Host(activeHost, openPorts, closedPorts));
        }

     // Sort the active and inactive hosts in ascending order
        Collections.sort(activeHosts);
        Collections.sort(inactiveHosts);

        // Set attributes to pass to the JSP
        req.setAttribute("activeHosts", activeHosts);
        req.setAttribute("inactiveHosts", inactiveHosts);
        req.setAttribute("targetNetwork", targetNetwork);
        req.setAttribute("hostList", hostList);

        // Total time taken for the entire scan
        long endTime = System.currentTimeMillis();
        System.out.println("Total Time Taken: " + (endTime - startTime) + " ms");
        
        // Forward results to output.jsp
        RequestDispatcher rd = req.getRequestDispatcher("/output.jsp");
        rd.forward(req, resp);
    }

    // Method to scan a single port
    private void scanPort(String host, int port, List<Integer> openPorts, List<Integer> closedPorts) {
        try (Socket socket = new Socket()) {
            socket.connect(new InetSocketAddress(host, port), 200); // 200 ms timeout for each port
            openPorts.add(port);
        } catch (IOException e) {
            closedPorts.add(port);
        }
    }

    // Check if a host is reachable
    private boolean isHostReachable(String ip, int timeout) throws IOException {
        return InetAddress.getByName(ip).isReachable(timeout);
    }

    // Method to generate a list of IP addresses in a given range or CIDR notation
    private List<String> getIPAddresses(String network) {
        List<String> ipList = new ArrayList<>();

        if (network.contains("*")) {
            String[] parts = network.split("\\.");
            List<String> addressCombinations = new ArrayList<>();
            generateCombinations(parts, 0, "", addressCombinations);
            ipList.addAll(addressCombinations);
        } else if (network.contains("/")) {
            ipList = parseCIDR(network);
        } else {
            ipList.add(network); // Single IP address
        }
        return ipList;
    }

    /**
     * Recursive function to generate combinations for wildcard IP addresses.
     */
    private void generateCombinations(String[] parts, int index, String current, List<String> addressCombinations) {
        // Base case: if we have completed all 4 parts, add the combination to the list
        if (index == parts.length) {
            addressCombinations.add(current.substring(1)); // Remove leading "."
            return;
        }

        // If the current part is a wildcard, generate 0-255
        if (parts[index].equals("*")) {
            for (int i = 0; i <= 255; i++) {
                generateCombinations(parts, index + 1, current + "." + i, addressCombinations);
            }
        } else {
            // If not a wildcard, keep the original part
            generateCombinations(parts, index + 1, current + "." + parts[index], addressCombinations);
        }
    }

    // Placeholder for CIDR parsing
    private List<String> parseCIDR(String network) {
        // Implement your CIDR parsing logic here
        return new ArrayList<>(); // Placeholder return
    }
}
