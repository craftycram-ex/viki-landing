<script setup>
import axios from 'axios'
import { onMounted, ref } from 'vue'

const ip = ref('')

onMounted(() => {
  axios
    .get('https://api.ipify.org?format=json')
    .then((response) => {
      ip.value = response.data.ip
    })
    .catch((error) => {
      console.error(error)
    })
})
</script>

<template>
  <main>
    <h1>welcome {{ ip }}</h1>
    <p>you're current public ip</p>
  </main>
</template>
