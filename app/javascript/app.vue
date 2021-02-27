<template>
  <div>
    <!-- チェックボックスがリセットされるのと、画面がちらつくのでコメントアウト -->
    <!-- <div v-if="$apollo.loading"> -->
    <b-button label="絞り込み" @click="isSearchModalActive = true" />
    <div>支払年月</div>
    <div>{{[...selectedYearMonths].sort()}}</div>
    <div>支払年月</div>
    <div>{{selectedUsers}}</div>

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

          <b-field label="ユーザー" grouped group-multiline>
            <b-checkbox-button v-model="selectedUsers"
              :native-value="user"
              v-for="user in selectableUsers">
              <span>{{user}}</span>
            </b-checkbox-button>
          </b-field>

          <b-field label="収支分類" grouped group-multiline>
            <b-checkbox-button v-model="paymentClassifications" native-value="食費">
              <span>食費</span>
            </b-checkbox-button>
            <b-checkbox-button v-model="paymentClassifications" native-value="外食">
              <span>外食</span>
            </b-checkbox-button>
            <b-checkbox-button v-model="paymentClassifications" native-value="水道光熱費">
              <span>水道光熱費</span>
            </b-checkbox-button>
            <b-checkbox-button v-model="paymentClassifications" native-value="通信費">
              <span>通信費</span>
            </b-checkbox-button>
            <b-checkbox-button v-model="paymentClassifications" native-value="日用品">
              <span>日用品</span>
            </b-checkbox-button>
            <b-checkbox-button v-model="paymentClassifications" native-value="一般保険料">
              <span>一般保険料</span>
            </b-checkbox-button>
            <b-checkbox-button v-model="paymentClassifications" native-value="娯楽費">
              <span>娯楽費</span>
            </b-checkbox-button>
            <b-checkbox-button v-model="paymentClassifications" native-value="コンビニで買ったおやつ">
              <span>コンビニで買ったおやつ</span>
            </b-checkbox-button>
            <b-checkbox-button v-model="paymentClassifications" native-value="本、雑誌">
              <span>本、雑誌</span>
            </b-checkbox-button>
            <b-checkbox-button v-model="paymentClassifications" native-value="服・美容">
              <span>服・美容</span>
            </b-checkbox-button>
            <b-checkbox-button v-model="paymentClassifications" native-value="ペット">
              <span>ペット</span>
            </b-checkbox-button>
            <b-checkbox-button v-model="paymentClassifications" native-value="交通費">
              <span>交通費</span>
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
      selectableUsers: ["たかひろ", "まいこ"],
      selectedUsers: [],
      paymentClassifications: [],
      paymentMethods: [],
      isSearchModalActive: false
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
