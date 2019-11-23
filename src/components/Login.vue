<template>
    <div>
        <button @click="connect">Connection</button>
    </div>
</template>

<script>
export default {
    name: 'Login',
    methods: {
        connect: function() {
            this.$store.dispatch('authRequest')
        }
    }
}
</script>