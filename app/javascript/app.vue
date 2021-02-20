<template>
  <div>
    <!-- チェックボックスがリセットされるのと、画面がちらつくのでコメントアウト -->
    <!-- <div v-if="$apollo.loading"> -->
    <!--   loading...                 -->
    <!-- </div>                       -->
    <!-- <div v-else>                 -->
      <div v-for="year_month in selectableYearMonths">
        <input type="checkbox" :id="year_month" v-on:click="toggle(year_month)">
          <label :for="year_month">{{year_month}}</label>
        </input>
      </div>
      <LineChart v-bind:chartData="datacollection"></LineChart>
    <!-- </div> -->

  </div>
</template>

<script>
import LineChart from "./LineChart"
import gql from "graphql-tag"

export default {
  components: {
    LineChart
  },
  data() {
    return {
      datacollection: {},
      selectableYearMonths: [],
      selectedYearMonths: [],
    }
  },
  methods: {
    toggle(year_month) {
      if (this.selectedYearMonths.includes(year_month)) {
        this.selectedYearMonths = this.selectedYearMonths.filter(x => x !== year_month)
      } else {
        this.selectedYearMonths.push(year_month)
      }
      this.$apollo.queries.datacollection.refetch()
    }
  },
  apollo: {
    datacollection: {
      query: gql`query($labels: [String]!) {
        datacollection(labels: $labels) {
          labels
          datasets {
            borderColor
            label
            data
            fill
          }
        }
      }`,
      variables() {
        return {
          labels: this.selectedYearMonths
        }
      }
    },
    selectableYearMonths: {
      query: gql`query {
        selectableYearMonths
      }`
    }
  }
}
</script>

<style>
</style>
