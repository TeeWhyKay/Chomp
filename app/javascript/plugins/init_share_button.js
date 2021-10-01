const initShareButton = () => {
  const shareButton = document.querySelector('#share-button');
  if (shareButton != null) {
    shareButton.addEventListener('click', event => {
      console.log("button clicked!");
      const link = document.querySelector('#share-link');
      if (navigator.share) { // on android chrome
        navigator.share({
          title: "Let's get Chomp to decide for us: ",
          url: `${link.value}`,
          text: "We can't decide where to eat, let's get Chomp to decide for us: "
        }).then(() => {
          console.log('Thanks for sharing!');
        })
          .catch(console.error);
      } else { // fallback on any other platform
        // click and popup message "link copied"
        link.select();
        document.execCommand("copy");
        const originalContent = shareButton.innerHTML
        shareButton.innerHTML = "Copied to clipboard!"
        //navigator.clipboard.readText().then(text => console.log(text));
        setTimeout(function () {
          shareButton.innerHTML = originalContent
        }, 1500)
      }
    });
  }
}

export { initShareButton };
