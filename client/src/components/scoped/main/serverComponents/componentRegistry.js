import System from "./system/System.svelte"
import ManagedFunctions from "./managedFunctions/ManagedFunctions.svelte"

const components = new Map()
components.set('system', {
    svelte: System,
    name: "System status"
    })
components.set('managed', {
    svelte: ManagedFunctions,
    name: "Managed Functions"
    })

export const getComponentById = (id) => {
    if(components.has(id))
        return components.get(id).svelte
    else
        return null
}

export const getNameById = (id) => {
    if(components.has(id))
    return components.get(id).name
else
    return null
} 

export const isInRegisty = (id) => components.has(id)