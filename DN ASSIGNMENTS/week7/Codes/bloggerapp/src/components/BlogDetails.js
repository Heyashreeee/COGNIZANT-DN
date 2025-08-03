import React from 'react';

function BlogDetails({ blogs }) {
  return (
    <div className="section">
      <h1>Blog Details</h1>
      {blogs.map((blog) => (
        <div key={blog.id}>
          <h2>{blog.title}</h2>
          <h4><i>{blog.author}</i></h4>
          <p>{blog.content}</p>
        </div>
      ))}
    </div>
  );
}

export default BlogDetails;
