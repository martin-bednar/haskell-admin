<script>
    import { connection } from '../../../../../stores.js'
    import {fetchEndpoint, fetchEndpointWithOptions} from '../../../../../lib/lib.js'
    import ProbeParam from './ProbeParam.svelte'

    export let probeId
    const pDetails = fetchEndpoint($connection, "managed", `/probes/${probeId}`)
        .then(rsp => rsp.json())

    let params = []
    let responseStatus = undefined
    let result = undefined
    const invoke = () => {
        const options = {
            method: 'POST',
            headers: {
                    'Content-Type': 'application/json'
                },
            body: JSON.stringify(params)
        }
        const endpoint = `/probes/${probeId}/invoke`
        fetchEndpointWithOptions($connection, "managed", endpoint, options)
            .then(rsp => { 
                responseStatus = rsp.status + " " + rsp.statusText; 
                return rsp.json();})
            .then(res => {result = res})
    }
</script>

<style>
    .probe {
        border: 1px solid #777;
        border-radius: 4px;
        margin: 1rem;
        padding: 1rem;
    }
    .status, .result {
        background-color: #ddd;
        border-radius: 4px;
        margin: 1rem;
        padding: .5rem;
    }
</style>

<div class="probe">
    <h3 class="probeId">
        {probeId}
    </h3>
{#await pDetails then details}
    <div>{probeId} :: {details.probeType}</div>
    {#each details.probeParams as param, i}
        <ProbeParam type={param} bind:value={params[i]} />
    {/each}
    <br>
    <button on:click={invoke}>Invoke {probeId}</button>
{/await}
{#if responseStatus}
    <div class="status">
        Status: 
        <em>
            {responseStatus}
        </em>
    </div>
{/if}
{#if result}
<div class="result">
    Result:
    <pre>{result}</pre> 
</div>
{/if}
</div>