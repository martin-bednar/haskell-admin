<script>
	import Header from "./components/global/Header.svelte"
	import Footer from "./components/global/Footer.svelte"
	import MainScreen from "./components/scoped/main/Main.svelte"
	import ConnectionScreen from "./components/scoped/connection/Connection.svelte"
	import SaveConnection from "./components/global/SaveConnection.svelte"
	import { connection } from './stores.js'

	let connected
	connection.subscribe(v => {connected = v.connected})
</script>

<style>
	.main {
		min-height: 100%;
    display: grid;
    grid-template-rows: auto 1fr auto;
    grid-template-columns: 100%;
	align-items: center;
	}
	.content {
		height: 100%;
		display: flex;
		align-items: center;
		justify-content: center;
	}
</style>

<SaveConnection />

<div class="main">
	<Header />
	<div class="content">	
	{#if connected === false}
		<ConnectionScreen />
	{:else}
		<MainScreen />
	{/if}
	</div>
	<Footer />
</div>