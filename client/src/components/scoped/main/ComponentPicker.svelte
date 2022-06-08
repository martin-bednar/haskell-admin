<script>
    import {isInRegisty, getNameById} from './serverComponents/componentRegistry'
    export let selectedComponent = null;
    export let components = [];
</script>

<style>
    .component-item {
        cursor: pointer;
        font-size: 1.2rem;
        background-color: #BDBDBD;
        transition: background-color 100ms linear;
        padding: .5rem;
    }
    .component-item:hover, .component-item.selected {
        background-color: #ffffff;
    }
    .component-item.selected {
        font-weight: bold;
    }
</style>

<div>
        {#each components as {componentName}}
            {#if isInRegisty(componentName)}
            <div 
                class="component-item" 
                class:selected="{selectedComponent === componentName}"
                on:click="{() => selectedComponent = componentName}"
                >{getNameById(componentName)}</div>
            {/if}
        {/each}
</div>