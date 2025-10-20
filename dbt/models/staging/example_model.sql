-- Example DBT model for staging data from the raw layer.
-- This model selects Python repositories from GitHub data.

SELECT
    name,
    full_name,
    description,
    stars,
    forks,
    language,
    url,
    created_at,
    updated_at
FROM
    {{ source('raw', 'github_repos') }}
WHERE
    language = 'Python'