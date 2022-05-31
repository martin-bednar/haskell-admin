<script>
    export let status = "Unknown"
</script>

<style>
    .beacon {
        background-color: #777;
        width: 2rem;
        height: 2rem;
        border-radius: 50%;
    }
    .beacon[data-status="Running"] {
        background-color: rgb(40, 230, 40);    
    }
    .beacon[data-status="Error"] {
        background-color: rgb(230, 40, 40);    
    }
    .beacon[data-status="Finished"] {
        background-color: rgb(40, 40, 230);    
    }
</style>

<div class="beacon" data-status={status}></div>