import Rails from '@rails/ujs'
const initLocation = () => {
  // const hiddenLocationInput = document.querySelector('#location');
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
        })

        // populateAddress(latitude, longitude)

        // ruby

        // routes
        // get "/responses/address", to: "responses#address"

        // def address
        //  lat = params[:lat]
        //  lng = params[:lng]
        //  something.search(lat, lng) => [results]

        // respond_to do
            // return json
        // end

        // javascript
        // fetch(/responses/address?lat=${lat}&lng=${lng}, {
          //
        // }).then(res => res.json()
          //
        // ).then(
          // true?
            // where is our input form? document.querySelector
            // formField.?? = ??
          // false
            // ??
        // )
      });
    });
  }
}

export { initLocation };
