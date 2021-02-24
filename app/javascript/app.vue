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
    <b-table :data="data">
      <b-table-column field="yearMonth" label="年月" v-slot="props">
        {{ props.row.yearMonth }}
      </b-table-column>
      <b-table-column field="income" label="収入" numeric v-slot="props">
        {{ props.row.income }}
      </b-table-column>
      <b-table-column field="payment" label="支出" numeric v-slot="props">
        {{ props.row.payment }}
      </b-table-column>
      <b-table-column field="total" label="合計" numeric v-slot="props">
        {{ props.row.total }}
      </b-table-column>
    </b-table>
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
      data: [],
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
          labels: [...this.selectedYearMonths].sort()
        }
      }
    },
    selectableYearMonths: {
      query: gql`query {
        selectableYearMonths
      }`
    },
    data: {
      query: gql`query($labels: [String]!) {
        data(labels: $labels) {
          yearMonth
          income
          payment
          total
        }
      }`,
      variables() {
        return {
          labels: [...this.selectedYearMonths].sort()
        }
      }
    }
  }
}
</script>

<style>
</style>
