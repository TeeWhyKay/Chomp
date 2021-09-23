import Rails from '@rails/ujs'
const initLocation = () => {
  // pass the accurate lat, long as hidden field
  const hiddenLocationInput = document.querySelector('#location');
  const locationBtn = document.querySelector('#get_location');

  if (locationBtn != null) {

    // const populateAddress = (?,?) => {
      // what do  you do
    // }

    locationBtn.addEventListener('click', (event) => {
      event.preventDefault()

      navigator.geolocation.getCurrentPosition((data) => {
        // hiddenLocationInput.value = `${data.coords.latitude},${data.coords.longitude}`
        console.log(data.coords.latitude)
        console.log(data.coords.longitude)

        const latitude = data.coords.latitude
        const longitude = data.coords.longitude
        fetch('/reverse_geocode', {
          method: 'POST',
          headers: { 'Accept': 'text/json', 'X-CSRF-token': Rails.csrfToken()},
          body: JSON.stringify({
            latitude: latitude,
            longitude: longitude})
        }).then(() => {
          const locationField = document.querySelector('#response_location');
          locationField.value = "Test address";
        });
        // .then(response => response.json())
        //   .then((data) => {
        //     console.log(data);
        //     const locationField = document.querySelector('#response_location');
        //     locationField.value = "Test address";
        //   });

        // populateAddress(latitude, longitude)
      });
    });
  }
}

export { initLocation };
