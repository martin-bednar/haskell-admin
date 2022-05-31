import { connection } from "../stores"

const TIMEOUT_MS = 5000

export const mkUrl = (connection, endpoint) => `${connection.protocol}://${connection.host}:${connection.port}${endpoint}`

const fetchServerWithOptions = (connection, endpoint, options) => {
    const controller = new AbortController()
    setTimeout(() => controller.abort(), TIMEOUT_MS)
    return fetch (
    mkUrl(connection, endpoint), 
    {
        ...options,
        headers: {
        ...options.headers,
        'Authorization': 'Bearer ' + connection.token
        },
        signal: controller.signal
    }).catch(err => {
        if(err.name == 'AbortError')
            throw new Error('Connection timed out')
    });
}

const fetchServer = (connection, endpoint) => fetchServerWithOptions(connection, endpoint, {})

export const checkConnection = (connection) => fetchServer(connection, "/").then(function(rsp) {
    if(rsp.status !== 200)
    {
       throw new Error(rsp.status + " " + rsp.statusText)
    }
    else return rsp.text()
})

export const fetchComponentList = 
    (connection) => 
        fetchServer(connection, "/components")
            .then(rsp => rsp.json())

export const fetchEndpoint = 
    (connection, component, endpoint) =>
    fetchEndpointWithOptions(connection, component, endpoint, {})

export const fetchEndpointWithOptions = 
    (connection, component, endpoint, options) =>
        fetchServerWithOptions(connection, `/components/${component}${endpoint}`, options)
