<script>
    import {getComponentById, getNameById} from "./serverComponents/componentRegistry"
    export let componentId = null
    let component
    $: component = getComponentById(componentId)
    $: name = getNameById(componentId)
</script>

{#if component}
    <h1>{name}</h1>
    <svelte:component this={component} />
{/if}
