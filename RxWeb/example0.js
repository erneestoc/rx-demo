// my super sophisticated app
const { range } = rxjs;
const { map, filter } = rxjs.operators;

range(1, 200)
  .pipe(
  	filter(x => x % 2 === 1),
  	map(x => x + x),
  	map(x => x * 2)
  )
  .subscribe(x => console.log(x));
