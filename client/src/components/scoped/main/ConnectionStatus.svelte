<script>
    import { mkUrl, checkConnection, fetchComponentList } from '../../../lib/lib.js';
    import { onDestroy } from 'svelte';
    import { connection, defConnection } from '../../../stores.js'
    import Button from '../../global/Button.svelte'
    
    function disconnect () {
        $connection = defConnection
    }

    let conectionOK = false

    const checkInterval = setInterval(() => {
        checkConnection($connection)
            .then(() => {conectionOK = true})
            .catch(() => {conectionOK = false})
    }, 1000);

    let url = mkUrl($connection, "") 
    export let pComponents = fetchComponentList($connection)

    onDestroy(() => clearInterval(checkInterval))
</script>

<style>
    .connStatus {
        display: grid;
        margin: 1rem;
        color: #666;
    }
</style>

<div class="connStatus">
    <span>
        Connection status: {conectionOK ? "Connected" : "Disconnected"}
    </span>
    <span>
        Server URL: {url}
    </span>
    {#await pComponents}
    Loading
    {:then componentList}
    {componentList.length} components loaded
    {:catch _}
        error loading components
    {/await}
    <Button onclick={disconnect}>Disconnect</Button>
</div>