<template>
  <div>
    <div v-if="loaded">
      <div v-for="year_month in year_months">
        <input type="checkbox" :id="year_month" v-on:click="toggle(year_month)">
          <label :for="year_month">{{year_month}}</label>
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
    toggle(year_month) {
      const displayed_datasets = this.datacollection.datasets
      const checked_dataset = this.all_datasets.find(x => x.label === year_month)
      let new_datasets = []

      if (displayed_datasets.includes(checked_dataset)) {
        new_datasets = displayed_datasets.filter(x => x !== checked_dataset)
      } else {
        new_datasets = displayed_datasets.concat()
        new_datasets.push(checked_dataset)
      }

      this.datacollection = {
        labels: this.dates,
        datasets: new_datasets,
      }
    }
  },
  computed: {
    year_months: function() {
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
