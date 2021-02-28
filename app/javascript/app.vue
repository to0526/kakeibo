<template>
  <div>
    <!-- チェックボックスがリセットされるのと、画面がちらつくのでコメントアウト -->
    <!-- <div v-if="$apollo.loading"> -->
    <b-button label="絞り込み" @click="isSearchModalActive = true" />
    <div>支払年月</div>
    <div>{{[...selectedYearMonths].sort()}}</div>
    <div>ユーザー</div>
    <div>{{selectedUsers.map(u => u.name)}}</div>
    <div>収支分類</div>
    <div>{{selectedPaymentClassifications.map(u => u.name)}}</div>

    <b-modal v-model="isSearchModalActive" has-modal-card>
      <div class="modal-card">
        <section class="modal-card-body">
          <b-field label="支払日" grouped group-multiline>
            <b-checkbox-button v-model="selectedYearMonths"
              :native-value="yearMonth"
              v-for="yearMonth in selectableYearMonths">
              <span>{{yearMonth}}</span>
            </b-checkbox-button>
          </b-field>

          <b-field label="収支分類" grouped group-multiline>
            <b-checkbox-button v-model="selectedPaymentClassifications"
              :native-value="paymentClassification"
              v-for="paymentClassification in paymentClassifications">
              <span>{{paymentClassification.name}}</span>
            </b-checkbox-button>
          </b-field>

          <b-field label="収支方法" grouped group-multiline>
            <b-checkbox-button v-model="paymentClassifications" native-value="現金">
              <span>現金</span>
            </b-checkbox-button>
            <b-checkbox-button v-model="paymentClassifications" native-value="クレジットカード(楽天)">
              <span>クレジットカード(楽天)</span>
            </b-checkbox-button>
            <b-checkbox-button v-model="paymentClassifications" native-value="クレジットカード(SEIYU)">
              <span>クレジットカード(SEIYU)</span>
            </b-checkbox-button>
            <b-checkbox-button v-model="paymentClassifications" native-value="クレジットカード(ヨドバシ)">
              <span>クレジットカード(ヨドバシ)</span>
            </b-checkbox-button>
            <b-checkbox-button v-model="paymentClassifications" native-value="クレジットカード(VISA)">
              <span>クレジットカード(VISA)</span>
            </b-checkbox-button>
            <b-checkbox-button v-model="paymentClassifications" native-value="iD">
              <span>iD</span>
            </b-checkbox-button>
            <b-checkbox-button v-model="paymentClassifications" native-value="SUICA">
              <span>SUICA</span>
            </b-checkbox-button>
            <b-checkbox-button v-model="paymentClassifications" native-value="クレジットカード(JR東海エクスプレス)">
              <span>クレジットカード(JR東海エクスプレス)</span>
            </b-checkbox-button>
            <b-checkbox-button v-model="paymentClassifications" native-value="引き落とし(三井住友)">
              <span>引き落とし(三井住友)</span>
            </b-checkbox-button>
            <b-checkbox-button v-model="paymentClassifications" native-value="クレジットカード(三井住友)">
              <span>クレジットカード(三井住友)</span>
            </b-checkbox-button>
            <b-checkbox-button v-model="paymentClassifications" native-value="銀行振込">
              <span>銀行振込</span>
            </b-checkbox-button>
            <b-checkbox-button v-model="paymentClassifications" native-value="クレジットカード(dカードGOLD)">
              <span>クレジットカード(dカードGOLD)</span>
            </b-checkbox-button>
          </b-field>
        </section>
      </div>
    </b-modal>

    <LineChart v-bind:chartData="datacollection"></LineChart>

    <b-table :data="data">
      <b-table-column field="yearMonth" label="年月" v-slot="props">
        {{ props.row.yearMonth }}
      </b-table-column>

      <b-table-column field="income" label="収入" numeric v-slot="props">
        <span :class="type(props.row.income)">
          {{ props.row.income }}
        </span>
      </b-table-column>

      <b-table-column field="payment" label="支出" numeric v-slot="props">
        <span :class="type(props.row.payment)">
          {{ props.row.payment }}
        </span>
      </b-table-column>

      <b-table-column field="total" label="合計" numeric v-slot="props">
        <span :class="type(props.row.total)">
          {{ props.row.total }}
        </span>
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
      users: [],
      selectedUsers: [],
      paymentClassifications: [],
      selectedPaymentClassifications: [],
      paymentMethods: [],
      isSearchModalActive: false,
      users: [],
    }
  },
  apollo: {
    datacollection: {
      query: gql`query($labels: [String]!, $userIds: [Int]!) {
        datacollection(labels: $labels, userIds: $userIds) {
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
          labels: [...this.selectedYearMonths].sort(),
          userIds: this.selectedUsers.map(u => Number(u.id))
        }
      }
    },
    selectableYearMonths: {
      query: gql`query {
        selectableYearMonths
      }`
    },
    data: {
      query: gql`query($labels: [String]!, $userIds: [Int]!) {
        data(labels: $labels, userIds: $userIds) {
          yearMonth
          income
          payment
          total
        }
      }`,
      variables() {
        return {
          labels: [...this.selectedYearMonths].sort(),
          userIds: this.selectedUsers.map(u => Number(u.id))
        }
      }
    },
    users: {
      query: gql`query {
        users {
          id
          name
        }
      }`
    },
    paymentClassifications: {
      query: gql`query {
        paymentClassifications {
          id
          name
        }
      }`
    },
  },
  methods: {
    type: function(value) {
      if (value.slice(0, 1) == "-") {
        return 'has-text-danger'
      } else {
        return 'has-text-info'
      }
    }
  }
}
</script>

<style>
</style>
