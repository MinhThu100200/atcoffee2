

<script>
import { defineComponent } from 'vue'
import { Pie } from 'vue3-chart-v2'
import * as Constants from '../../../common/Constants'

export default defineComponent({
  name: Constants.COMPONENT_NAME_PIE_CHART,

  extends: Pie, 
  props: {
    chartData: {
      required: true
    },
    chartOptions: {
      required: false
    },
    key: {

    }
  },

  mounted () {
    this.renderChart(this.chartData, this.chartOptions)
  }
})
</script>

