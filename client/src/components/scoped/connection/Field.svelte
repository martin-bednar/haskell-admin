<script>
    export let label = ""
    export let name = ""
    export let value = ""
    export let placeholder = ""
</script>

<style>
    input {
        border-radius: 3px;
        padding: 0.25em;
        border: 1px solid #8A8A8A;
        font-size: 1rem;
    }
    ::placeholder {
        font-style: italic;
    }
</style>

<label for={name}>{label}</label>
<input type="text" name={name} id={name} bind:value={value} placeholder={placeholder}>