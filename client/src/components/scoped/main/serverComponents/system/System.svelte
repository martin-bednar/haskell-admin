<script>
    import { onDestroy } from 'svelte';
    import { connection } from '../../../../../stores.js'
    import {fetchEndpoint} from '../../../../../lib/lib.js'
    import StatusBeacon from "./StatusBeacon.svelte"

    const unknownStatus = {
        tag: "Unknown",
        contents: "Server unreachable"
    }

    export let status = unknownStatus

    const interval = setInterval(function() {
        fetchEndpoint($connection, "health", "/status")
            .then(rsp => rsp.json())
            .then(val => {status = val})
            .catch(err => {
                status = {
                    tag: "Unknown",
                    contents: err
                }
            })
    }, 500)

    onDestroy(() => clearInterval(interval))
</script>

<style>
    .status {
    padding: 1rem;
    margin: 1rem;
    border-radius: 4px;
    border: 1px solid #eee;
    display: grid;
    grid-template-columns: 1fr 3fr;
    grid-template-rows: 1fr auto;
    max-width: 20rem;
    gap: 5px;
    grid-template-areas:
            "beacon title"
            "contents contents";
    justify-content: center;
    align-items: center;
    }
    .contents {
        grid-area: contents;
    }
</style>

<div class="status">
    <StatusBeacon status={status.tag} />
    <strong>{status.tag}</strong>
    <span class="contents">
        {#if status.contents}
        {status.contents}
        {/if}
    </span>
</div>
