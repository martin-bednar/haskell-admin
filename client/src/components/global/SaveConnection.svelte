<script>
    import { connection } from '../../stores'
    connection.subscribe(val => localStorage.setItem("connection", JSON.stringify(val)));
</script>

<div></div>