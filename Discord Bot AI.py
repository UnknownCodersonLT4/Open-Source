# THIS IS ALL CREATED BY SLAYERSON AKA proplayerson2.0 on discord
# DM ME FOR MORE INFO My discord is : proplayerson on discord

import discord
from discord.ext import commands
import json
import os
from datetime import datetime, timezone
import asyncio
import aiohttp

# Bot configuration
BOT_TOKEN = 'ADD_YOUR_DISCORD_BOT_TOKEN_HERE!'  # Replace with your Discord bot token
API_BASE_URL = "https://api.groq.com/openai/v1/chat/completions"
API_KEY = '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'  # here is a free api 
CHAT_FILE = 'chat_history.json'

intents = discord.Intents.default()  
intents.message_content = True  
bot = commands.Bot(command_prefix='x', intents=intents)

class AIDiscordBot:
    def __init__(self):
        self.chats = self.load_chats()
        self.api_config = {
            'base_url': API_BASE_URL,
            'model': "llama3-8b-8192",  # there are different Ai models you can chose from bot "llama3-8b-819" and "meta-llama/llama-4-scout-17b-16e-instruct" are the best ones.
            'default_params': {
                'temperature': 0.9,
                'max_tokens': 1024,
                'top_p': 1,
                'frequency_penalty': 0,
                'presence_penalty': 0
            }
        }

    def load_chats(self):
        """Load chat history from JSON file."""
        if os.path.exists(CHAT_FILE):
            with open(CHAT_FILE, 'r') as f:
                return json.load(f)
        return {}

    def save_chats(self):
        """Save chat history to JSON file."""
        with open(CHAT_FILE, 'w') as f:
            json.dump(self.chats, f, indent=2)

    def get_channel_messages(self, channel_id):
        """Get messages for a specific channel."""
        channel_id = str(channel_id)
        if channel_id not in self.chats:
            self.chats[channel_id] = {
                'id': channel_id,
                'title': f'Channel {channel_id}',
                'messages': []
            }
        return self.chats[channel_id]

    async def send_api_request(self, messages):
        """Send request to the AI API."""
        async with aiohttp.ClientSession() as session:
            try:
                async with session.post(
                    self.api_config['base_url'],
                    headers={
                        'Content-Type': 'application/json',
                        'Authorization': f'Bearer {API_KEY}'
                    },
                    json={
                        'model': self.api_config['model'],
                        'messages': [
                            {
                                'role': 'system',
                                'content': 'You are an AI assistant in a Discord bot, providing helpful and accurate responses.'
                            },
                            *messages
                        ],
                        **self.api_config['default_params']
                    }
                ) as response:
                    if response.status == 200:
                        data = await response.json()
                        return data['choices'][0]['message']['content']
                    else:
                        return f"Error: Unable to get response from AI API (Status: {response.status})."
            except Exception as e:
                return f"Error: {str(e)}"

    def render_message(self, content):
        """Return the message content directly."""
        return content

    async def handle_chat(self, ctx, message):
        """Handle chat logic for a given message."""
        channel_id = str(ctx.channel.id)
        chat = self.get_channel_messages(channel_id)

        
        chat['messages'].append({
            'role': 'user',
            'content': message,
            'timestamp': datetime.now(timezone.utc).isoformat()
        })

       
        if len(chat['messages']) == 1:
            chat['title'] = message[:30] + ('...' if len(message) > 30 else '')

        
        async with ctx.typing():
           
            api_messages = [{'role': msg['role'], 'content': msg['content']} 
                           for msg in chat['messages'][-10:]]  

            # Get AI response
            response = await self.send_api_request(api_messages)
            
            
            chat['messages'].append({
                'role': 'assistant',
                'content': response,
                'timestamp': datetime.now(timezone.utc).isoformat()
            })

            
            self.save_chats()

            
            if len(response) > 4000:
                response = response[:3997] + '...'  
                await ctx.send(response)
                await ctx.send("*(Response truncated due to Discord's 4000-character limit)*")
            else:
                await ctx.send(response)

@bot.event
async def on_ready():
    print(f'Logged in as {bot.user.name}')

bot_instance = AIDiscordBot()

@bot.event
async def on_message(message):
    """Handle all incoming messages."""
    
    if message.author == bot.user:
        return

    
    if message.content.startswith(bot.command_prefix):
        await bot.process_commands(message)
    else:
        
        ctx = await bot.get_context(message)
        await bot_instance.handle_chat(ctx, message.content)

@bot.command(name='chat')
async def chat_command(ctx, *, message):
    """Handle chat command with user message (optional, for backward compatibility)."""
    await bot_instance.handle_chat(ctx, message)

@bot.command(name='clear')
async def clear_chat(ctx):
    """Clear chat history for the current channel."""
    channel_id = str(ctx.channel.id)
    if channel_id in bot_instance.chats:
        bot_instance.chats[channel_id]['messages'] = []
        bot_instance.save_chats()
        await ctx.send("Chat history cleared!")
    else:
        await ctx.send("No chat history to clear.")

@bot.command(name='history')
async def show_history(ctx):
    """Show recent chat history."""
    channel_id = str(ctx.channel.id)
    chat = bot_instance.get_channel_messages(channel_id)
    
    if not chat['messages']:
        await ctx.send("No messages in this channel yet.")
        return

    response = f"**Chat History ({chat['title']})**\n\n"
    for msg in chat['messages'][-5:]:  
        role = 'User' if msg['role'] == 'user' else 'AI'
        content = msg['content'][:100] + ('...' if len(msg['content']) > 100 else '')
        response += f"**{role}** ({msg['timestamp']}):\n{content}\n\n"
    
    
    if len(response) > 4000:
        response = response[:3997] + '...'  
        await ctx.send(response)
        await ctx.send("*(History truncated due to Discord's 4000-character limit)*")
    else:
        await ctx.send(response)

@bot.command(name='export')
async def export_chat(ctx):
    """Export chat history as JSON."""
    channel_id = str(ctx.channel.id)
    chat = bot_instance.get_channel_messages(channel_id)
    
    export_data = {
        'chat_id': channel_id,
        'title': chat['title'],
        'messages': chat['messages'],
        'export_date': datetime.now(timezone.utc).isoformat(),
        'version': 'Slayerson AI V1'
    }
    
    with open(f'chat_export_{channel_id}.json', 'w') as f:
        json.dump(export_data, f, indent=2)
    
    await ctx.send(file=discord.File(f'chat_export_{channel_id}.json'))
    os.remove(f'chat_export_{channel_id}.json')

bot.run(BOT_TOKEN)
