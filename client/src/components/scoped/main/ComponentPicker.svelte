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
        {#each components as component}
            {#if isInRegisty(component)}
            <div 
                class="component-item" 
                class:selected="{selectedComponent === component}"
                on:click="{() => selectedComponent = component}"
                >{getNameById(component)}</div>
            {/if}
        {/each}
</div>