<script>
import { Line, mixins } from "vue-chartjs"
const { reactiveProp } = mixins

export default {
  extends: Line,
  mixins: [reactiveProp],
  props: {
    chartData: {
      type: Object,
      default: null
    }
  },
  data() {
    return {
      options: {
        responsive: true,
        maintainAspectRatio: false,
        spanGaps: true,
      }
    }
  },
  mounted() {
    this.renderChart(this.chartData, this.options)
  }
}
</script>

<style>
</style>
