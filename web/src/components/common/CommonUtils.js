const CommonUtils = {
  
  fromNow(timeStamp) {
    let seconds = (new Date().getTime() - timeStamp) / 1000;
    let interval = Math.floor(seconds / 31536000);
    if (interval >= 1) {
      return interval + 'năm trước';
    } 
    interval = Math.floor(seconds / 2592000);
    if (interval >= 1) {
      return interval + " tháng trước";
    }
    interval = Math.floor(seconds / 86400);
    if (interval >= 1) {
      return interval + " ngày trước";
    }
    interval = Math.floor(seconds / 3600);
    if (interval >= 1) {
      return interval + " giờ trước";
    }
    interval = Math.floor(seconds / 60);
    if (interval >= 1) {
      return interval + " phút trước";
    }
    return Math.floor(seconds) + " giây trước";
  },

  formatDate(date) {
    return ('0' + date.getDate()).slice(-2) + '-' + ('0' + (date.getMonth() + 1)).slice(-2) + '-' + date.getFullYear();
  },

  formatDateReverse(date) {
    return date.getFullYear() + '-' + ('0' + (date.getMonth() + 1)).slice(-2) + '-' + ('0' + date.getDate()).slice(-2);
  },

  formatDateTime(date) {
    return `${('0' + date.getHours()).slice(-2)}:${('0' + date.getMinutes()).slice(-2)} ` + ('0' + date.getDate()).slice(-2) + '-' + ('0' + (date.getMonth() + 1)).slice(-2) + '-' + date.getFullYear();
  },

  regexTime(time) {
    var regex = /^([0-1]?[0-9]|2[0-3]):[0-5][0-9]$/
    return regex.test(time);
  },

  formatPrice(price) {
    return new Intl.NumberFormat('de-DE', { style: 'currency', currency: 'VND' }).format(price)
  },

  paginate(array, page_size, page_number) {
    return array.slice((page_number - 1) * page_size, page_number * page_size);
  },
}

export default CommonUtils;