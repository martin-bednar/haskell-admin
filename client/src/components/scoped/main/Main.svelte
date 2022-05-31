<script>
    import { fetchComponentList } from '../../../lib/lib.js';
    import { connection } from '../../../stores.js'
    import ConnectionStatus from "./ConnectionStatus.svelte"
    import ComponentPicker from "./ComponentPicker.svelte"
    import RenderComponent from "./RenderComponent.svelte"

    let pComponents = fetchComponentList($connection)
    let selectedComponent = null
</script>

<style>
main {
    display: grid;
    grid-template-columns: 20em 1fr;
    height: 100%;
    width: 100%;
}

.sidebar {
    background-color: #F5F5F5;
}

.component-area {
    margin: 2rem;
}

</style>

<main>
    <aside class="sidebar">
        <ConnectionStatus pComponents={pComponents} />
        {#await pComponents then componentList}
        <ComponentPicker components={componentList} bind:selectedComponent={selectedComponent} />
        {/await}
    </aside>
    <div class="component-area">
        <RenderComponent componentId={selectedComponent} />
    </div>
</main>