<template>
  <div class="row-custom">
    <div class="row flex-1">
      <div class="col-12">
        <div class="card card-pie">
          <div class="card-header">
            <h4>Sản phẩm bán chạy</h4>
          </div>
          <div class="card-body">
            <pie-chart :chartData="bestSellingData" :chartOptions="chartPieOptions" v-if="isPieChart"/>
          </div>
        </div>
      </div>
    </div>
    <div class="white-space"></div>
    <div class="row flex-2">
      <div class="col-12">
        <div class="card">
          <div class="card-header">
            <h4>Doanh thu</h4>
          </div>
          <div class="card-body">
            <line-chart :chartData="revenueData" :chartOptions="chartOptions" v-if="isLineChart"/>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import * as Constants from '../../../common/Constants'
import CommonUtils from '../../../common/CommonUtils'
import BillCommand from '../../../command/BillCommand'
import ProductCommand from '../../../command/ProductCommand'
import LineChart from '../../common/chart/LineChart.vue'
import PieChart from '../../common/chart/PieChart.vue'

export default {
  name: Constants.COMPONENT_NAME_REVENUE_DASHBOARD,

  components: {
    LineChart,
    PieChart
  },

  data() {
    return {
      isLineChart: false,
      isPieChart: false,
      revenueData: {
        labels: [],
        datasets: [
          {
            label: 'Doanh thu theo ngày trong tháng (Nghìn đồng)',
            backgroundColor: '#fb7571',
            borderColor: '#fb7571',
            borderWidth: 2,
            fill: false,
            data: []
          }
        ]
      },

      chartOptions: {
        responsive: true,
        maintainAspectRatio: false,
        scales: {
          yAxes: [{
              ticks: {
                  beginAtZero: true
              }
          }]
        }
      },

      bestSellingData: {
        labels: [],
        datasets: [
          {
            label: 'Số lượng sản phẩm bán trong tháng (Sản phẩm)',
            backgroundColor: ['#fb7571', '#4198d7', '#d8b655', '#7a61ba', '#46d39a', '#e55759', '#cccccc'],
            borderColor: ['#fb7571', '#4198d7', '#d8b655', '#7a61ba', '#46d39a', '#e55759', '#cccccc'],
            borderWidth: 2,
            fill: false,
            data: []
          }
        ]
      },

      chartPieOptions: {
        responsive: false
      },
    }
  },

  methods: {

    processRevenueData(dataPre) {
      let labels = [];
      let data = [];
      let len = new Date().getDate();
      for (let day = 0; day < len; day ++) {
        if (dataPre[0] != null && parseInt(dataPre[0].createdDate.slice(-2)) == day + 1) {
          let bill = dataPre.shift();
          data.push(bill.amount / 1000);
        } else {
          data.push(0);
        }
        labels.push((day + 1) + '');
      }
      this.revenueData.labels = labels;
      this.revenueData.datasets[0].data = data;
      this.isLineChart = true;
    },

    async processBestSellingData(dataPre) {
      let labels = [];
      let data = [];
      var products = await this.loadProducts();
      for (let index = 0; index < dataPre.length; index++) {
        var product = products.find(item => item.id == dataPre[index].productId);
        labels.push(product?.name);
        data.push(dataPre[index].quantity);
      }
      this.bestSellingData.labels = labels;
      this.bestSellingData.datasets[0].data = data;
      this.isPieChart = true;
    },

    processFavoriteProducts(bills) {
      this.isPieChart = false;
      let billDetails = [];
      bills.forEach(item => {
        billDetails = billDetails.concat(item.billDetails);
      })
      const data = Array.from(billDetails.reduce(
        (m, {productId, quantity}) => m.set(productId, (m.get(productId) || 0) + quantity), new Map
      ), ([productId, quantity]) => ({productId, quantity}));
      data.sort((a, b) => {
        return b.quantity - a.quantity;
      })
      this.processBestSellingData(data.slice(0, 5));
    },

    processRevenue(bills) {

      let newBills = bills.map(item => {
        item.createdDate = CommonUtils.formatDateReverse(new Date(item.createdDate));
        return item;
      });
      const data = Array.from(newBills.reduce(
        (m, {createdDate, amount}) => m.set(createdDate, (m.get(createdDate) || 0) + amount), new Map
      ), ([createdDate, amount]) => ({createdDate, amount}));
      this.processRevenueData(data);
    },

    async loadBills() {
      this.isLineChart = false;
      var now = new Date();
      var end = CommonUtils.formatDateReverse(now);
      var start = end.slice(0, 8) + '01';
      let result = await BillCommand.findByDateBetween(start, end);
      this.processRevenue(result);
      this.processFavoriteProducts(result);
    },

    async loadProducts() {
      return await ProductCommand.findAllByOrderIgnore(1, Constants.PAGE_SIZE_MAX, null, null, null);
    }
  },

  created(){
    this.loadBills();
    this.loadProducts();
  }
}
</script>

<style scoped>
.row-custom {
  display: flex;
  flex-direction: row;
}

.flex-wrap {
  flex-wrap: wrap;
}

.flex-2 {
  flex: 2 !important;
}

.white-space {
  width: 20px;
}

.cart .card-body {
  padding-top: 12px !important;
}

.card.card-pie .card-body {
  display: flex;
  justify-content: center;
  align-items: center;
}
</style>