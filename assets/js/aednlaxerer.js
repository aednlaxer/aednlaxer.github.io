function shuffle(original) {
  let list = original.split('')
  list = list.sort(() => Math.random() - 0.5)
  return list.join('')
}

function generateNickname() {
  let shuffled = 'a' + shuffle('lexand') + 'er'
  document.getElementById('nickname').innerHTML = shuffled
}
