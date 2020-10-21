<template>
  <div>
    <div v-if="loaded">
      <input type="checkbox" id="2020/07" v-on:click="toggle('2020/07')">
        <label for="2020/07">2020/07</label>
      </input>
      <input type="checkbox" id="2020/08" v-on:click="toggle('2020/08')">
        <label for="2020/08">2020/08</label>
      </input>
      <input type="checkbox" id="2020/09" v-on:click="toggle('2020/09')">
        <label for="2020/09">2020/09</label>
      </input>
      <LineChart v-bind:chartData="datacollection"></LineChart>
    </div>
    <div v-else>
      loading...
    </div>

  </div>
</template>

<script>
import LineChart from "./LineChart"

const dates = [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31]

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
