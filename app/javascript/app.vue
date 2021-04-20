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
    <div>収支方法</div>
    <div>{{selectedPaymentMethods.map(u => u.name)}}</div>

    <b-modal v-model="isSearchModalActive" has-modal-card>
      <div class="modal-card">
        <section class="modal-card-body">
          <b-checkbox v-model="checkAll">すべてチェック</b-checkbox>

          <b-field label="支払日" grouped group-multiline>
            <b-checkbox-button v-model="selectedYearMonths"
              :native-value="yearMonth"
              v-for="yearMonth in selectableYearMonths">
              <span>{{yearMonth}}</span>
            </b-checkbox-button>
          </b-field>

          <b-field label="ユーザー" grouped group-multiline>
            <b-checkbox-button v-model="selectedUsers"
              :native-value="user"
              v-for="user in users">
              <span>{{user.name}}</span>
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
            <b-checkbox-button v-model="selectedPaymentMethods"
              :native-value="paymentMethod"
              v-for="paymentMethod in paymentMethods">
              <span>{{paymentMethod.name}}</span>
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
      selectedPaymentMethods: [],
      isSearchModalActive: false,
      checkAll: false,
    }
  },
  apollo: {
    datacollection: {
      query: gql`query($labels: [String]!, $userIds: [Int]!, $paymentClassificationIds: [Int]!, $paymentMethodIds: [Int]!) {
        datacollection(labels: $labels, userIds: $userIds, paymentClassificationIds: $paymentClassificationIds, paymentMethodIds: $paymentMethodIds) {
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
          userIds: this.selectedUsers.map(u => Number(u.id)),
          paymentClassificationIds: this.selectedPaymentClassifications.map(u => Number(u.id)),
          paymentMethodIds: this.selectedPaymentMethods.map(u => Number(u.id)),
        }
      }
    },
    selectableYearMonths: {
      query: gql`query {
        selectableYearMonths
      }`
    },
    data: {
      query: gql`query($labels: [String]!, $userIds: [Int]!, $paymentClassificationIds: [Int]!, $paymentMethodIds: [Int]!) {
        data(labels: $labels, userIds: $userIds, paymentClassificationIds: $paymentClassificationIds, paymentMethodIds: $paymentMethodIds) {
          yearMonth
          income
          payment
          total
        }
      }`,
      variables() {
        return {
          labels: [...this.selectedYearMonths].sort(),
          userIds: this.selectedUsers.map(u => Number(u.id)),
          paymentClassificationIds: this.selectedPaymentClassifications.map(u => Number(u.id)),
          paymentMethodIds: this.selectedPaymentMethods.map(u => Number(u.id)),
        }
      }
    },
    paymentMethods: {
      query: gql`query {
        paymentMethods {
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
    },
  },
  watch: {
    checkAll: function(val) {
      if (val == true) {
        this.selectedUsers = this.users
        this.selectedYearMonths = this.selectableYearMonths
        this.selectedPaymentClassifications = this.paymentClassifications
        this.selectedPaymentMethods = this.paymentMethods
      } else {
        this.selectedUsers = []
        this.selectedYearMonths = []
        this.selectedPaymentClassifications = []
        this.selectedPaymentMethods = []
      }
    },
  },
  mounted() {
    fetch("/api/users")
      .then(res =>    { return res.json() })
      .then(json =>   { this.users = json })
      .catch(error => { alert("ユーザを取得できませんでした") })
    fetch("/api/payment_classifications")
      .then(res =>    { return res.json() })
      .then(json =>   { this.paymentClassifications = json })
      .catch(error => { alert("支払い分類を取得できませんでした") })
  }
}
</script>

<style>
</style>
