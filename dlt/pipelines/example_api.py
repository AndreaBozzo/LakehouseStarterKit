"""Example DLT pipeline to fetch data from GitHub API and load it into DuckDB."""

import dlt
import requests


@dlt.resource(write_disposition="replace")
def github_repos():
    """
    Fetch popular repositories from GitHub API.
    https://api.github.com/search/repositories returns trending repositories.
    """
    response = requests.get(
        "https://api.github.com/search/repositories",
        params={"q": "stars:>10000", "sort": "stars", "per_page": 100}
    )
    response.raise_for_status()
    data = response.json()

    # The API returns data in format: {"total_count": N, "items": [...]}
    items = data.get("items", [])

    for item in items:
        # Extract only relevant fields
        yield {
            "name": item.get("name"),
            "full_name": item.get("full_name"),
            "description": item.get("description"),
            "stars": item.get("stargazers_count"),
            "forks": item.get("forks_count"),
            "language": item.get("language"),
            "url": item.get("html_url"),
            "created_at": item.get("created_at"),
            "updated_at": item.get("updated_at"),
        }


if __name__ == "__main__":
    pipeline = dlt.pipeline(
        pipeline_name="openlakehouse_demo",
        destination="duckdb",
        dataset_name="raw"
    )

    load_info = pipeline.run(github_repos)
    print("Pipeline completed successfully!")
    print(f"Load ID: {load_info.loads_ids[0]}")
    print("Table: raw.github_repos")
