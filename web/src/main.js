import { createApp } from 'vue'
import excel from 'vue-excel-export'
import App from './App.vue'
import router from './routers';
import store from './store'
import vClickOutside from 'click-outside-vue3'
import "bootstrap/dist/css/bootstrap.min.css"
import "bootstrap"
// import AxiosPlugin from 'vue-axios-cors';

const app = createApp(App);
app.use(router).use(store).use(excel);
app.use(vClickOutside);
// app.use(AxiosPlugin);
// app.use(cors({
//   origin: 'http://localhost:8080',
//   credentials: true,
//   allowedHeaders: ['Content-Type', 'Authorization']
// }));
// app.use(cors({ origin: '*'}));

  
app.mount('#app');