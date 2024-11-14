<template>
  <div>
    <form @submit.prevent="submitForm">
      <label for="name">Name:</label>
      <input type="text" v-model="name" id="name" required>
      <button type="submit">Insert Data</button>
    </form>
    <p>{{ message }}</p>
  </div>
</template>

<script>
export default {
  data() {
    return {
      name: '',
      message: ''
    };
  },
  methods: {
    async submitForm() {
      try {
        const response = await fetch('http://localhost:8080/insert', {
          method: 'POST',
          headers: {
            'Content-Type': 'text/plain',
          },
          body: this.name
        });
        
        if (response.ok) {
          this.message = await response.text();
        } else {
          this.message = 'Failed to insert data.';
        }
      } catch (error) {
        console.error('Error inserting data:', error);
        this.message = 'Failed to insert data.';
      }
    }
  }
};
</script>

<style scoped>
/* You can add custom CSS styles here if needed */
</style>