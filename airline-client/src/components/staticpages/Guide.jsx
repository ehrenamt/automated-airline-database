import ReactMarkdown from 'react-markdown';

const guideMDContent = `
# User Guide

This is a basic guide for the Sequel Airlines Website.
`

const Guide = () => {
    return (
        <div>
            <ReactMarkdown>{guideMDContent}</ReactMarkdown>
        </div>
    );
};

export default Guide;
