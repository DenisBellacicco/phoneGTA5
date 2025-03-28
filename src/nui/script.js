document.addEventListener('DOMContentLoaded', () => {
    window.addEventListener('message', (event) => {
        if (event.data.action === "open") {
            document.getElementById('phone').style.display = 'block';
            updateContacts(event.data.contacts);
        } else {
            document.getElementById('phone').style.display = 'none';
        }
        if (event.data.action === "receiveSMS") {
            alert('Nouveau SMS: ' + event.data.message);
        }
        if (event.data.action === "incomingCall") {
            document.getElementById('caller').innerText = event.data.caller;
            document.getElementById('callNotification').style.display = 'block';
            setTimeout(() => {
                document.getElementById('callNotification').style.display = 'none';
            }, 5000);
        }
    });
});

function closePhone() {
    fetchNui('closePhone').catch(console.error);
}

function addContact() {
    let name = document.getElementById('contactName').value;
    let number = document.getElementById('contactNumber').value;
    fetchNui('addContact', { name, number }).catch(console.error);
}

function sendSMS() {
    let target = document.getElementById('smsTarget').value;
    let message = document.getElementById('smsMessage').value;
    fetchNui('sendSMS', { target, message }).catch(console.error);
}

function makeCall() {
    let target = document.getElementById('callTarget').value;
    fetchNui('makeCall', { target }).catch(console.error);
}

function fetchNui(action, data = {}) {
    return fetch(`https://${GetParentResourceName()}/${action}`, {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify(data)
    }).catch(console.error);
}

function updateContacts(contacts) {
    let contactDiv = document.getElementById('contacts');
    contactDiv.innerHTML = '';
    contacts.forEach(contact => {
        let div = document.createElement('div');
        div.textContent = contact.name + ' (' + contact.number + ')';
        contactDiv.appendChild(div);
    });
}