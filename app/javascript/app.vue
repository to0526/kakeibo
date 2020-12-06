<template>
  <div>
    <div v-if="loaded">
      <div v-for="month in months">
        <input type="checkbox" :id="month" v-on:click="toggle(month)">
          <label :for="month">{{month}}</label>
        </input>
      </div>
      <LineChart v-bind:chartData="datacollection"></LineChart>
    </div>
    <div v-else>
      loading...
    </div>

  </div>
</template>

<script>
import LineChart from "./LineChart"

let dates = []
for (let i = 1; i <= 31; i++) {
  dates.push(i)
}

export default {
  components: {
    LineChart
  },
  data() {
    return {
      datacollection: {
        labels: dates,
        datasets: null,
      },
      dates: dates,
      all_datasets: [],
      loaded: false,
    }
  },
  methods: {
    toggle(month) {
      const datasets = this.datacollection.datasets
      const dataset = datasets.find(x => x.label === month)
      let new_datasets = []
      const new_dataset = this.all_datasets.find(x => x.label === month)

      if (dataset === undefined) {
        new_datasets = datasets.concat()
        new_datasets.push(new_dataset)
      } else {
        new_datasets = datasets.filter(x => x !== new_dataset)
      }

      this.datacollection = {
        labels: this.dates,
        datasets: new_datasets,
      }
    }
  },
  computed: {
    months: function() {
      return this.all_datasets.map(x => x.label)
    }
  },
  created() {
    fetch("/api/payments")
      .then(response => response.json())
      .then(data => this.all_datasets = data)
      .catch(e => alert(e))
    this.loaded = true
  }
}
</script>

<style>
</style>
