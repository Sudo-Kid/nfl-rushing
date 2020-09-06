import React, {useState, useEffect} from 'react';
import './App.css';

function App() {
  const [pageData, setPageData] = useState({
    data: [],
    page_number: 1,
    page_size: 0,
    total_entries: 0,
    total_pages: 0,
  });
  const [pageNumber, setPageNumber] = useState(1);
  const [sortBy, setSortBy] = useState('name');
  const [direction, setDirection] = useState('asc');
  const [filter, setFilter] = useState(null);
  const order = [
    "Player", "Team", "Pos", "Att", "Att/G", "Yds", "Avg", "Yds/G", "TD", "Lng", "1st", "1st%", "20+", "40+", "FUM"
  ];

  useEffect(() => {
    let url = `/api/players?sort_by=${sortBy}&sort_direction=${direction}&page=${pageNumber}`
    if (filter !== null) {
      url += `&filter=${filter}`
    }
    fetch(url)
      .then(res => res.json())
      .then(response => {
        setPageData(response)
      })
      .catch(error => alert(error));
  }, [sortBy, direction, filter, pageNumber])

  const updateFilter = (event) => {
    setFilter(event.target.value);
  }

  const updateData = (value) => {
    if (value === sortBy) {
      setDirection(direction === 'asc'?'desc':'asc');
    }
    if (value !== sortBy) {
      setDirection('desc');
      setSortBy(value);
    }
  }

  const updateOrder = (event) => {
    switch (event.target.innerText) {
      case "Total Rushing Yards":
        updateData('yds');
        break;
      case "Longest Rush":
        updateData('lng');
        break;
      case "Total Rushing Touchdowns":
        updateData('td');
        break;
      default:
        return;
    }
  }

  const downloadCSV = (event) => {
    let url = `/api/players/download?sort_by=${sortBy}&sort_direction=${direction}`
    if (filter !== null) {
      url += `&filter=${filter}`
    }
    window.open(url);
    event.preventDefault();
  }

  const incrementPage = () => {
    if (pageNumber < pageData.total_pages) {
      const newPageNumber = pageNumber + 1;
      setPageNumber(newPageNumber);
    }
  }

  const decrementPage = () => {
    if (pageNumber > 1) {
      const newPageNumber = pageNumber - 1;
      setPageNumber(newPageNumber);
    }
  }

  return (
    <div className="container-fluid">
      <nav className="navbar navbar-dark bg-dark">
        <span className="navbar-brand mb-0 h1">NFL Rushing</span>
      </nav>
      <form onSubmit={(event) => {event.preventDefault()}}>
        <div className="form-group">
          <label htmlFor="filterName">Filter By Name</label>
          <input type="text"
                 className="form-control"
                 id="filterName"
                 aria-describedby="filterNameHelp"
                 onChange={updateFilter}
          />
        </div>
        <button type="downloa" className="btn btn-primary" onClick={downloadCSV}>Download CSV</button>
      </form>
      <br/>
      <table className="table">
        <thead>
          <tr>
            <th scope="col">Player</th>
            <th scope="col">Team</th>
            <th scope="col">Position</th>
            <th scope="col">Rushing Attempts Per Game Average</th>
            <th scope="col">Rushing Attempts</th>
            <th scope="col" onClick={updateOrder} className="order-by text-primary">Total Rushing Yards</th>
            <th scope="col">Rushing Average Yards Per Attempt</th>
            <th scope="col">Rushing Yards Per Game</th>
            <th scope="col" onClick={updateOrder} className="order-by text-primary">Total Rushing Touchdowns</th>
            <th scope="col" onClick={updateOrder} className="order-by text-primary">Longest Rush</th>
            <th scope="col">Rushing First Downs</th>
            <th scope="col">Rushing First Down Percentage</th>
            <th scope="col">Rushing 20+ Yards Each</th>
            <th scope="col">Rushing 40+ Yards Each</th>
            <th scope="col">Rushing Fumbles</th>
          </tr>
        </thead>
        <tbody>
          {pageData.data.map((player, i) =>
            <tr key={i}>
              {order.map((key, index) =>
                <td key={index}>{pageData.data[i][key]}</td>
              )}
            </tr>
          )}
        </tbody>
      </table>
      <nav aria-label="Page navigation example">
        <ul className="pagination">
          <li className="page-item">
            <button className="page-link" onClick={decrementPage}>
              Previous
            </button>
          </li>
          <li className="page-item">
            <button className="page-link" onClick={incrementPage}>
              Next
            </button>
          </li>
        </ul>
      </nav>
    </div>
  );
}

export default App;
