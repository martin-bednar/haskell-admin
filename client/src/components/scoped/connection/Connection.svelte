<script>
    import { connection } from '../../../stores.js'
    import Field from './Field.svelte'
    import Button from '../../global/Button.svelte'
    import { checkConnection } from '../../../lib/lib'
    
    let pTestConnection = undefined

    function connect () {
        $connection.connected = true
    }
    function test () {
        pTestConnection = checkConnection($connection)
    }
</script>

<style>
    .connection {
        max-width: 30em;
        margin: auto;
        background-color: #DFDFDF;
        border: 1px solid rgba(0, 0, 0, 0.6);
        border-radius: 4px;
    }
    .connection--inner {
        margin: 2em;
    }
    .fields {
        display: grid;
        grid-template-columns: 1fr 1fr;
        row-gap: 1em;
    }
    .buttons {
        display: flex;
        flex-direction: row;
        justify-content: space-between;
        margin: 2em 0 0 0;
    }
    select {
        font-size: 1rem;
    }
</style>
<main class="connection">
    <div class="connection--inner">
        <h1>Connection</h1>
        <div class="form">
            <div class="fields">
                <label for="protocol">Protocol</label>
                <select name="protocol" id="protocol" bind:value={$connection.protocol}>
                    <option value="https">https</option>
                    <option value="http">http</option>
                </select>
                <Field label="Host" bind:value={$connection.host} name="host" placeholder="localhost" />
                <Field label="Port" bind:value={$connection.port} name="port" placeholder="3001" />
                <Field label="API Key" bind:value={$connection.token} name="token" placeholder="952bc31c-aa61-4f06-8e19" />
            </div>
            <div class="buttons">
                <Button onclick={test}>Test connection</Button>
                <Button onclick={connect}>OK</Button>
            </div>
            {#if pTestConnection}
                
                {#await pTestConnection}
                    Testing connection...
                {:then} 
                    Connection established
                {:catch err}
                <p>Can't connect</p>
                <p>{err}</p>
                {/await}

            {/if}
        </div>
    </div>  
</main>