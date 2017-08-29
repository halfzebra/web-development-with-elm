import {Main} from './Main.elm';

const app = Main.embed(document.getElementById('root'));

app.ports.output.subscribe(console.log);

setTimeout(
  () => {
    app.ports.incoming.send([
      {score: 1, total: 2}
    ])
  },
  1000
);
