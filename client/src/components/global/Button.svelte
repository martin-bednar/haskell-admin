<script>
    export let onclick = () => {}
</script>

<style>
        button {
        font-size: 1rem;
        min-width: 5em;
        padding: .25em .5em;
        cursor: pointer;
    }
</style>

<button on:click={onclick}>
    <slot></slot>
</button>