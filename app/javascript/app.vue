<template>
  <div>
    <!-- チェックボックスがリセットされるのと、画面がちらつくのでコメントアウト -->
    <!-- <div v-if="$apollo.loading"> -->
    <section>
      <b-field grouped group-multiline>
        <b-checkbox-button v-model="selectedYearMonths"
          :native-value="yearMonth"
          v-for="yearMonth in selectableYearMonths">
          <span>{{yearMonth}}</span>
        </b-checkbox-button>
      </b-field>
    </section>
    <LineChart v-bind:chartData="datacollection"></LineChart>
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
          data {
            income
            payment
            total
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
