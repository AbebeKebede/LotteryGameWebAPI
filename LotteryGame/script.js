document.addEventListener('DOMContentLoaded', function () {
    const buyTicketBtn = document.getElementById('buyTicketBtn');
    const drawTicketBtn = document.getElementById('drawTicketBtn');

    const resultMessage = document.getElementById('resultMessage');

    buyTicketBtn.addEventListener('click', function () {
        var email = document.getElementById('email').value;
        var username = document.getElementById('username').value;
        // Call server-side API to handle payment and lottery ticket purchase
        fetch('https://localhost:7011/api/lottery/buyTicket', 
        { method: 'POST',
        headers: {
            'Content-Type': 'application/json',
        },
        body: JSON.stringify({
            email: email,
            username: username
        })
        })
            .then(response => response.json())
            .then(data => {
                if (data.success) {
                    resultMessage.innerText = 'Ticket purchased successfully. Waiting for the next draw... Your ticket number is: '+ data.ticketNumber;
                } else {
                    resultMessage.innerText = 'Transaction failed. Please try again.';
                }
            });
    });

    drawTicketBtn.addEventListener('click', function () {
        // Call server-side API to handle payment and lottery ticket purchase
        fetch('https://localhost:7011/api/lottery/generateLotteryNumbers', { method: 'GET' })
            .then(response => response.json())
            .then(data => {
                if (data.success) {
                    resultMessage.innerText = 'The winning ticket number is: '+ data.lotteryNumbers;
                } else {
                    resultMessage.innerText = 'Transaction failed. Please try again.';
                }
            });
    });

});


