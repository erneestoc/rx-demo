// my super sophisticated app
const { fromEvent } = rxjs;
const { ajax } = rxjs.ajax;
const { map, pluck, mergeMap, retry, debounceTime } = rxjs.operators;

const input = document.getElementById("textInput")

const resultSelector = (e) => e.target.value

const searchText = (value) => {
	return ajax.post('https://qa1.weperk.com/', value)
}

fromEvent(input, 'keyup').pipe(
  pluck('target', 'value'),
  debounceTime(1500),
  mergeMap(searchText),
  retry(3)
).subscribe()