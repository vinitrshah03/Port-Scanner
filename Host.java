package com.project.security;

import java.util.List;

public class Host {
    private String ip;
    private List<Integer> openPorts;
    private List<Integer> closedPorts;

    // Constructor
    public Host(String ip, List<Integer> openPorts, List<Integer> closedPorts) {
        this.ip = ip;
        this.openPorts = openPorts;
        this.closedPorts = closedPorts;
    }

    // Getters
    public String getIp() {
        return ip;
    }

    public List<Integer> getOpenPorts() {
        return openPorts;
    }

    public List<Integer> getClosedPorts() {
        return closedPorts;
    }
}
