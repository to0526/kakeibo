<script>
import { Line } from "vue-chartjs"

export default {
  extends: Line,
  props: {
    chartdata: {
      type: Object,
      default: null
    }
  },
  data() {
    return {
      options: {
        responsive: true,
        maintainAspectRatio: false
      }
    }
  },
  mounted() {
    this.renderChart(this.chartdata, this.options)
  }
}
</script>

<style>
</style>
