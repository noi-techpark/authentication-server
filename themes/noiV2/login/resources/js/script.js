// trim spaces from username/email field
document.addEventListener("DOMContentLoaded", function(event) {
    let username = document.getElementById("username");
    username.addEventListener("change", (event) => {
        username.value = username.value.replaceAll(" ", "")
    });

});
