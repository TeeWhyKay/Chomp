const initLocation = () => {
  const hiddenLocationInput = document.querySelector('#location');
  const locationBtn = document.querySelector('#get_location');

  if (locationBtn != null) {
    locationBtn.addEventListener('click', (event) => {
      event.preventDefault()
      navigator.geolocation.getCurrentPosition((data) => {
        hiddenLocationInput.value = `${data.coords.latitude},${data.coords.longitude}`
        console.log(data.coords.latitude)
        console.log(data.coords.longitude)
      });
    });
  }
}

export { initLocation };
