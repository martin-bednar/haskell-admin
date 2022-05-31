import { writable } from 'svelte/store';

export const defConnection = {
    protocol: "https",
    host: "",
    port: "",
    token: "",
    connected: false
}

function initConn() {
    return JSON.parse(localStorage.getItem("connection")) || defConnection;
}

export const connection = writable(initConn());
