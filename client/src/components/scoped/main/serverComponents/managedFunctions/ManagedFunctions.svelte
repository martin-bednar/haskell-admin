<script>
    import { connection } from '../../../../../stores.js'
    import {fetchEndpoint} from '../../../../../lib/lib.js'
    import Probe from './Probe.svelte'
    const pProbeList 
        = fetchEndpoint($connection, "managed", "/probes")
        .then(rsp => rsp.json())
</script>

{#await pProbeList}
    Loading Probes...
    {:then probeList}
    {probeList.length} Probes loaded.
    {#each probeList as probe}
        <Probe probeId={probe} />
    {/each}
{/await}