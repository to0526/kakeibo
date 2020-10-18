<template>
  <LineChart v-bind:chartdata="chartdata"></LineChart>
</template>

<script>
import LineChart from "./LineChart"

const dates = [...Array(32).keys()]
dates.shift()

const selectable_months = ["2020/07", "2020/08", "2020/09", "2020/10"]
const disabled_months = [
  {
    label: '2020/07',
    data: [100,200,300]
  },
  {
    label: '2020/08',
    data: [0,100,200,300]
  },
  {
    label: '2020/09',
    data: [0,0,100,200,300]
  },
  {
    label: '2020/10',
    data: [0,0,0,100,200,300]
  }
]

export default {
  components: {
    LineChart
  },
  data() {
    return {
      chartdata: {
        labels: dates,
        datasets: disabled_months,
      }
    }
  }
}
</script>

<style>
</style>
