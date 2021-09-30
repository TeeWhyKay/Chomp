const initTextParser = () => {
  const chompSessionTime = document.querySelector("#chomp-session-time");
  const chompSessionName = document.querySelector("#chomp-session-name");
  const whatTime = (givenTime) => {
    return chompSessionName.value.toLowerCase().includes(givenTime)
  }
  const checkInputField = (e) => {
    const thereIsBreakfast = whatTime("breakfast") || whatTime("morning");
    const thereIsBrunch = whatTime("brunch");
    const thereIsLunch = whatTime("lunch") || whatTime("afternoon");
    const thereIsDinner = whatTime("dinner") || whatTime("evening");
    const thereIsSupper = whatTime("supper") || whatTime("night");
    if (thereIsBreakfast) {
      chompSessionTime.value = "09:00:00"
    } else if (thereIsBrunch) {
      chompSessionTime.value = "11:00:00"
    } else if (thereIsLunch) {
      chompSessionTime.value = "13:00:00"
    } else if (thereIsDinner) {
      chompSessionTime.value = "18:00:00"
    } else if (thereIsSupper) {
      chompSessionTime.value = "22:00:00"
    }
  };

  if (chompSessionName) {
    chompSessionName.addEventListener("keyup", checkInputField);
  }
};

export { initTextParser };
